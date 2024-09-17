function [Cv, Cv_true, L, Fi] = VoronoiDecomposition(p, a_hat)
% This function is used by the Simulink scheme to compute the real and
% estimated centroids. It also computes the Laplacian and the quantity Fi
% needed for the parameters estimate

    coverage2D_parameters; %get parameters
    
    px = p(:,1);
    py = p(:,2);

    [v,c,p] = VoronoiLimit(px ,py,'bs_ext',bs_ext,'figure', 'off');
    
    Cv = zeros(2,n);
    Cv_true = zeros(2,n);
    order = zeros(n,1);
    Fi = zeros(9,9,n);
    for i=1:n
    
        vind = c{i};
        vx = v(vind,1)';
        vy = v(vind,2)';
        pos_x = find(px==p(i,1));
        pos_y = find(py==p(i,2));
        order(pos_x) = i;

        % Reorder centroids based on robot order
        if pos_x == pos_y
            %[Cv(:,pos_x), Cv_true(:,pos_x), Fi] = integrate_over_cell(vx,vy,p(i,:),a_hat(:,pos_x), kappa, Fi, pos_x);

            a_hat_i = a_hat(:,pos_x);
            pi = p(i,:);

            % Perform integration
            
            % Sample points
            % random sampling
            cnt = 10000; % Sample count
            xp = min(vx) + rand(cnt,1)*(max(vx)-min(vx));
            yp = min(vy) + rand(cnt,1)*(max(vy)-min(vy));
            
            % linear sampling
            %cnt = 10000; % Sample count
            %n_samples = sqrt(cnt); % Number of points per dimension (assuming square)
            %
            %xp = linspace(min(vx), max(vx), n_samples); % Linearly spaced x-values
            %yp = linspace(min(vy), max(vy), n_samples); % Linearly spaced y-values
            %
            %[X, Y] = meshgrid(xp, yp);
            %
            %xp = X(:); 
            %yp = Y(:);
            %
            %in = inpolygon(xp,yp,vx,vy); % subset points in voronoi region 
            %xp = xp(in);
            %yp = yp(in);

            
            % Integrals over voronoi region
            kq = kappa(xp,yp);
            % estimated
            phi_est = kq * a_hat_i;
            mv = sum(phi_est);
            cx = sum(xp.*phi_est)/mv;
            cy = sum(yp.*phi_est)/mv;
            
            % actual
            phi = kq * a;
            cx_true = sum(xp.*phi)/sum(phi);    
            cy_true = sum(yp.*phi)/sum(phi);
            Cvi_true = [cx_true;cy_true]; 
            
            % Check for negative mass
            if mv < 0
               disp(strcat('Negative mass calculated: ',num2str(mv)));
               %disp(pos)
               %disp(ai_t')
            end
            
            % Check for calculated centroid in voronoi region
            if inpolygon(cx,cy,vx,vy) == 0
                disp('Centroid outside the region');
                %disp(ai_t');
                Cvi = pi';
            else
                Cvi = [cx;cy];
            end
            
            % Update paramter Fi
            k1 = zeros(9,2);
            for j = 1:length(xp)
                q_pi = ([xp(j) yp(j)] - pi);
                k1 = k1 + kq(j,:)'*q_pi;
            end

            Fi(:,:,pos_x) = (1/mv)*(k1*K*k1');
            Cv(:,pos_x) = Cvi;
            Cv_true(:,pos_x) = Cvi_true;



        else
            disp('Mismatch in position found')
            [Cv(:,pos_x)] = p(i,:)';
            [Cv_true(:,pos_x)] = p(i,:)';
        end
    end

    % Laplacian: Shared edge length as weight
    T = delaunayTriangulation(px,py);
    ed = edges(T);
    L = zeros(n,n);
    for ind = 1:length(ed)
        r1 = ed(ind,1);
        r2 = ed(ind,2);
        points = intersect(c{order(r1)},c{order(r2)});
        if length(points)==2
            edge_len = pdist(v(points,:),'euclidean');
        else
            edge_len = 0;
        end
        L(r1,r2)= -edge_len;
        L(r2,r1)= -edge_len;
    end
    L = L + diag(-1*sum(L,2));

end
