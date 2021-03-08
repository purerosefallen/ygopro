--高速决斗技能-太阳神合一
Duel.LoadScript("speed_duel_common.lua")
function c100730101.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730101.skill,c100730101.con,aux.Stringid(100730101,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730101.Isgod(c)
	return c:IsOriginalCodeRule(10000010) and c:IsFaceup()
end

function c100730101.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730101.Isgod,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetMZoneCount(tp)>-1
end
function c100730101.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730101)
	local g=Duel.GetMatchingGroup(c100730101.Isgod,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	local lp=Duel.GetLP(tp)
	while tc do
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(lp)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end