--高速决斗技能-卡组统领：突击兵
Duel.LoadScript("speed_duel_common.lua")
function c100730185.initial_effect(c)
	aux.SpeedDuelReplaceDraw(c,c100730185.skill,c100730185.con,aux.Stringid(100730185,0))
	aux.SpeedDuelBeforeDraw(c,c100730185.skill2)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730185.skill2(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c100730185.kaicon)
	e1:SetTarget(c100730185.cfilter)
	e1:SetValue(800)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.Clone(e1)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	Duel.RegisterEffect(e2,tp)
	e:Reset()
end
function c100730185.cfilter(e,c)
	return c:IsRace(RACE_MACHINE) or c:IsRace(RACE_WARRIOR)
end
function c100730185.kaicon(e,tp)
	return Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_MZONE+LOCATION_SZONE,0,1,nil,6400512)
end

function c100730185.con(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_DECK,0,nil,6400512)>0
		and Duel.GetTurnCount()>=2
end
function c100730185.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730185,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730185)
		local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_DECK,0,nil,6400512)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
	end
end