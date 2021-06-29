--高速决斗技能-卡组统领：突击兵
Duel.LoadScript("speed_duel_common.lua")
function c100730130.initial_effect(c)
	aux.SpeedDuelReplaceDraw(c,c100730130.skill,c100730130.con,aux.Stringid(100730130,0))
	aux.SpeedDuelBeforeDraw(c,c100730130.skill2)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730130.skill2(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c100730130.kaicon)
	e1:SetTarget(c100730130.cfilter)
	e1:SetValue(800)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.Clone(e1)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	Duel.RegisterEffect(e2,tp)
	e:Reset()
end
function c100730130.cfilter(e,c)
	return c:IsRace(RACE_MACHINE) or c:IsRace(RACE_WARRIOR)
end
function c100730130.kaicon(e)
	return Duel.IsExistingMatchingCard(c100730130.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c100730130.filter(c)
	return c:IsFaceup() and c:IsCode(6400512)
end
function c100730130.con(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_DECK,0,nil,47372349,6400512)>0
		and Duel.GetMZoneCount(tp)>0
		and Duel.GetTurnCount()>=2
end
function c100730130.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730130,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730130)
		local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_DECK,0,nil,47372349,6400512)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		local xc=Duel.CreateToken(tp,90844184)
		Duel.SpecialSummon(xc,0,tp,tp,true,true,POS_FACEDOWN_DEFENSE)
	end
end