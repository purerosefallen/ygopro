--高速决斗技能-凡人的局限
Duel.LoadScript("speed_duel_common.lua")
function c100730057.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730057.skill,c100730057.con,aux.Stringid(100730057,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730057.filter(c)
	return c:IsType(TYPE_MONSTER)
end

function c100730057.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730057.filter,tp,0,LOCATION_GRAVE,1,nil)
		and Duel.GetLP(tp)+2000<=Duel.GetLP(1-tp)
end

function c100730057.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730057)
	local g1=Duel.GetMatchingGroup(c100730057.filter,tp,0,LOCATION_GRAVE,nil)
	local g2=Group.CreateGroup()
	local tc=g1:GetFirst()
	while tc do
		if tc:IsType(TYPE_MONSTER) then
			g2:AddCard(Duel.CreateToken(1-tp,32274490))
		else
			g2:AddCard(Duel.CreateToken(1-tp,tc:GetOriginalCode()))
		end
		tc=g1:GetNext()
	end
	Duel.Exile(g1,REASON_RULE)
	Duel.SendtoGrave(g2,REASON_RULE)
	e:Reset()
end